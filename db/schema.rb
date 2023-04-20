# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_04_18_121246) do

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "stripe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "amount"
    t.integer "payment_method"
    t.integer "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "credit_card_number"
    t.string "credit_card_exp_month"
    t.string "credit_card_exp_year"
    t.string "credit_card_cvv"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "order_id", null: false
    t.string "stripe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "credit_card_number"
    t.string "credit_card_exp_month"
    t.string "credit_card_exp_year"
    t.string "credit_card_cvv"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "amount"
    t.string "status"
    t.string "stripe_payment_id"
    t.integer "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_transactions_on_order_id"
  end

  add_foreign_key "orders", "customers"
  add_foreign_key "payments", "orders"
  add_foreign_key "transactions", "orders"
end
