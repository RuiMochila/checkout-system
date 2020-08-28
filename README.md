# Checkout System with Flexible Promotion Rules

`PromotionDiscountType` and `PromotionRuleType` allow for an explicit way of specifying the kind of promotion we're dealing with. It specifies the type of promotion trigger and the kind of impact it has on products / overall basket total.

`PromotionRule` stores necessary information regarding promotions

> if `promotion_type` equals `PromotionRuleType::TOTAL_SPENT` - `activation_ammount` will hold pounds

> if `promotion_type` equals `PromotionRuleType::PRODUCT_AMMOUNT` - `activation_ammount` will hold a product count

> if `discount_type` equals `PromotionDiscountType::ABSOLUTE` - `discount_ammount` will hold pounds to apply a flat price reduction

> if `discount_type` equals `PromotionDiscountType::PERCENTAGE` - `discount_ammount` will hold a percentage

Run spec

```
rspec spec
``` 
