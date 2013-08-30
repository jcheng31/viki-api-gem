require 'spec_helper'

describe Viki::Invoice, api: true do
  it 'fetches invoices' do
    stub_api 'users/1u/invoices.json', Oj.dump({'id' => '1pi', 'user_id' => '1u',
                                       'provider_invoice_id' => 'in_1x',
                                       'payment_provider' => 'stripe'})

    described_class.fetch(user_id: '1u') do |res|
      res.value['id'].should eq '1pi'
      res.value['user_id'].should eq '1u'
    end

    described_class.fetch(user_id: '1u', provider_invoice_id: 'in_1x') do |res|
      res.value['id'].should eq '1pi'
      res.value['provider_invoice_id'].should eq 'in_1x'
    end

    described_class.fetch(user_id: '1u', payment_provider: 'stripe') do |res|
      res.value['id'].should eq '1pi'
      res.value['payment_provider'].should eq 'stripe'
    end
  end
end
