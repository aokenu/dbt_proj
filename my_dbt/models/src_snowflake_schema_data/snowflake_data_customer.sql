with customers as (
    select C_CUSTOMER_SK as customerId,  
            C_CURRENT_CDEMO_SK as customerDemo, 
            C_CURRENT_HDEMO_SK as customerHomeDemo, 
            C_SALUTATION as title, 
            C_FIRST_NAME as firstName, 
            C_LAST_NAME as lastName
    from {{ source('sf_customer', 'CUSTOMER') }}

),

sales as (
    select WS_BILL_CUSTOMER_SK as customerId,
           WS_BILL_CDEMO_SK as customerDemo,
           WS_WEB_SITE_SK as websiteId,
           WS_ORDER_NUMBER as orderNumber,
           WS_QUANTITY as quantity,
           WS_SALES_PRICE as salePrice
    from {{ source('sf_customer', 'WEB_SALES') }}

),


final as (
    select c.customerId,
           c.customerDemo,
           c.firstName,
           c.lastName,
           w.websiteId,
           w.orderNumber,
           w.quantity,
           w.salePrice
    from customers c
    inner join sales w
    on c.customerId = w.customerId

)

select * from final