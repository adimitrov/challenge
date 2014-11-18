require 'spec_helper'

module Stackexchange
  describe Client do
    subject(:client) { Stackexchange::Client.new }

    context 'with array of tags' do
      it 'should fetch tags', :vcr do
        result = client.tag_info(['ruby', 'java'])
        expect(result).to be_a_kind_of(Hash)
        expect(result.keys).to include('ruby', 'java')
      end
    end

    context 'with single tag' do
      it 'should fetch tags', :vcr do
        result = client.tag_info('ruby')
        expect(result).to be_a_kind_of(Hash)
        expect(result.keys).to include('ruby')
      end
    end

    context 'with no tags' do
      it 'should throw exception for unsupportet arguments' do
        expect { client.tag_info(nil) }.to raise_error ArgumentError
        expect { client.tag_info({}) }.to raise_error ArgumentError
        expect { client.tag_info() }.to raise_error ArgumentError
      end
    end

    context 'from yaml file' do
      context 'valid yaml', :vcr do
        it 'should call #tag_info with valid tags' do
          expect(client).to receive(:tag_info).with(["ruby", "scheme", "haskell"])
          client.tag_info_from_yaml(File.expand_path('../../fixtures/languages1.yml', File.dirname(__FILE__)))
        end
      end
      context 'invalid yaml' do
        it 'should raise an error' do
          expect {
            client.tag_info_from_yaml(File.expand_path('../../fixtures/languages_malformed.yml', File.dirname(__FILE__)))
          }.to raise_error
        end
      end
    end
  end
end
