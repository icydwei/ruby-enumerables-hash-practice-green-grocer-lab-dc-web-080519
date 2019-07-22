require 'pry'

def consolidate_cart(cart)
  final_cart = {}
  cart.each do |item|
    #binding.pry
    if final_cart.include?(item.keys[0])
      #binding.pry
      final_cart[item.keys[0]][:count] += 1
    else
      final_cart[item.keys[0]] = {}
      final_cart[item.keys[0]][:price] = item[item.keys[0]][:price]
      final_cart[item.keys[0]][:clearance] = item[item.keys[0]][:clearance]
      final_cart[item.keys[0]][:count] = 1
    end
  end
  return final_cart
end

def apply_coupons(cart, coupons = {})
  couponcart = {}
  cart.each do |item|
    #binding.pry
    couponcart[item[0]] = {}
    couponcart[item[0]][:price] = item[1][:price]
    couponcart[item[0]][:clearance] = item[1][:clearance]
    couponcart[item[0]][:count] = item[1][:count]  
      coupons.each do |coupon|
        #binding.pry
        if couponcart.include?(coupon[:item])
          #binding.pry
          if couponcart[item[0]][:count] >= coupon[:num]
            #binding.pry
            couponcart[item[0]][:count] = (couponcart[item[0]][:count] - coupon[:num])
            couponitemname = item[0] + " W/COUPON"
            if couponcart[couponitemname]
              couponcart[couponitemname][:count] += coupon[:num]
            else  
              couponcart[couponitemname] = {}
              couponcart[couponitemname][:price] = coupon[:cost]/coupon[:num]
              couponcart[couponitemname][:clearance] = item[1][:clearance]
              couponcart[couponitemname][:count] = coupon[:num]
            end
          end
        end
      end
  end
  #binding.pry
  return couponcart
end

def apply_clearance(cart)
  clearancecart = {}
  cart.each do |item|
    clearancecart[item[0]] = {}
    clearancecart[item[0]][:price] = item[1][:price]
    clearancecart[item[0]][:clearance] = item[1][:clearance]
    clearancecart[item[0]][:count] = item[1][:count]
    if clearancecart[item[0]][:clearance] == true
      #binding.pry
      clearancecart[item[0]][:price] = (clearancecart[item[0]][:price]*0.8).round(2)
    end
  end
  return clearancecart
end

def checkout(cart, coupons)
  cons_cart = consolidate_cart(cart)
  cons_coup_cart = apply_coupons(cons_cart, coupons)
  cons_coup_clear_cart = apply_clearance(cons_coup_cart)
  cons_coup_clear_cart.reduce(nil) do |total, item|
    #binding.pry
    itemprice = item[2][:price] * item[2][:count]
    total = total + itemprice
  end
  if total > 100
    total = (total * 0.9).round(2)
  end
  return total
end
