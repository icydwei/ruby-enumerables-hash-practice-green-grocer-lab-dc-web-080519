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

def apply_coupons(cart, coupons)
  couponcart = {}
  cart.each do |item|
    #binding.pry
      coupons.each do |coupon|
        binding.pry
        if cart.include?(coupon[:item])
          binding.pry
          if item[1][:count] > coupon[:num]
            item[1][:count] = item[1][:count] - coupon[:num]
            couponitemname = item[1][:price]
          end
        else 
          couponcart[item.keys[0]] = {}
          couponcart[item.keys[0]][:price] = item[1][:price]
          couponcart[item.keys[0]][:clearance] = item[1][:clearance]
          couponcart[item.keys[0]][:count] = item[1][:count]
        end
      end
  end
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
