WITH
  data_transaksi AS (
  SELECT
    a.transaction_id,
    a.date,
    a.branch_id,
    b.branch_name,
    b.kota,
    b.provinsi,
    b.rating AS rating_cabang,
    a.customer_name,
    a.product_id,
    c.product_name,
    a.price AS actual_price,
    a.discount_percentage,
    CASE
      WHEN a.price <= 50000 THEN 0.10
      WHEN a.price > 50000
    AND a.price <= 100000 THEN 0.15
      WHEN a.price > 100000 AND a.price <= 300000 THEN 0.20
      WHEN a.price > 300000
    AND a.price <= 500000 THEN 0.25
      ELSE 0.30
  END
    AS persentase_gross_laba,
    a.price * (1 - a.discount_percentage / 100) AS nett_sales,
    (a.price * (1 - a.discount_percentage / 100)) *
    CASE
      WHEN a.price <= 50000 THEN 0.10
      WHEN a.price > 50000
    AND a.price <= 100000 THEN 0.15
      WHEN a.price > 100000 AND a.price <= 300000 THEN 0.20
      WHEN a.price > 300000
    AND a.price <= 500000 THEN 0.25
      ELSE 0.30
  END
    AS nett_profit,
    a.rating AS rating_transaksi
  FROM
    `kimia_farma.kf_final_transaction` AS a
  JOIN
    `kimia_farma.kf_kantor_cabang` AS b
  ON
    a.branch_id = b.branch_id
  JOIN
    `kimia_farma.kf_product` AS c
  ON
    a.product_id = c.product_id )
SELECT
  *
FROM
  data_transaksi;