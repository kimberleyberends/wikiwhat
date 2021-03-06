require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'json'
require 'rest_client'
require 'vcr'
require 'spec_helper'

require_relative 'testfiles/api_call_contents'

describe Wikiwhat::Call do
  describe '.call_api' do
    context 'extract call' do
      it 'forms the call string & uses RestClient to make API call' do
        VCR.use_cassette('kel_extract') do

          api_output = Wikiwhat::Call.call_api('Kel Mitchell', prop:'extracts')

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(ext_output)
        end
      end
    end

    context 'revisions call' do
      it 'forms the call string & uses RestClient to make API call' do
        VCR.use_cassette('kel_revisions') do
          api_output = Wikiwhat::Call.call_api('Kel Mitchell', prop:'revisions',
          rvprop:true)

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(rev_output)
        end
      end
    end

    context 'image list call' do
      it "forms the call string & uses RestClient to make API call"  do
        VCR.use_cassette('albert') do
          api_output = Wikiwhat::Call.call_api('Albert Einstien', img_list:true, inprop:true, prop:"info")

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(img_output)
        end
      end
    end

    context 'image url call ' do
      it "uses RestClient to make API call"  do
        VCR.use_cassette('image_url') do
          api_output = Wikiwhat::Call.call_api("File:Kelmitchellpic.jpg",
            prop:"imageinfo", iiprop:true)

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(img_url_output)
        end
      end
    end

    context 'image thumbnail call' do
      it "uses RestClient to make API call" do
        VCR.use_cassette('image_thumbnail') do
          api_output = Wikiwhat::Call.call_api("File:Kelmitchellpic.jpg",
            prop:"imageinfo", iiprop:true, iiurlwidth:250)

          expect(api_output).to be_a(Hash)
          expect(api_output).to eq(apispec_img_thumbnail)
        end
      end
    end
  end
end
