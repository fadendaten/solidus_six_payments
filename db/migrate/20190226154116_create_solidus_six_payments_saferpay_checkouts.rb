class CreateSolidusSixPaymentsSaferpayCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :solidus_six_payments_saferpay_checkouts do |t|
      t.string :token
      t.references :order
      t.timestamps

      t.index :token, unique: true
    end
  end
end
