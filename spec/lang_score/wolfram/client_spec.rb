module Wolfram
  describe Client do
    subject(:client) { Wolfram::Client.new(appid: 'E6R6JY-G9X7Y4JPH3') }

    describe '.influenced' do
      context 'with no or wrong api key' do
        it 'should raise an error', :vcr do
          expect { Wolfram::Client.new.influenced(%w(ruby clojue)) }.to raise_error ArgumentError
        end
      end

      context 'with api key' do
        it 'should return an array of languages', :vcr do
          expect(client.class).to receive(:get)
            .with("/v2/query", { query: { appid: 'E6R6JY-G9X7Y4JPH3', input: "ruby,clojue" } })
            .and_call_original

          result = client.influenced(%w(ruby clojue))
          expect(result).to be_kind_of(Array)
          expect(result).to include('coffeescript')
        end
      end
    end

    describe '.normalize_languages' do
      it 'should normalize language names' do
        languages = client.normalize_languages(["Windows PowerShell", "Perl 6", "CoffeeScript"])
        expect(languages).to include("powershell", "perl-6", "coffeescript")
      end
    end

    context 'from yaml file' do
      context 'with valid yaml' do
        it 'should call #influenced with valid languages', :vcr do
          expect(client).to receive(:influenced).with(%w(ruby scheme haskell))
          client.influenced_from_yaml(File.expand_path('../../fixtures/languages1.yml', File.dirname(__FILE__)))
        end
      end
      context 'with invalid yaml' do
        it 'should raise an error' do
          expect {
            client.influenced_from_yaml(File.expand_path('../../fixtures/languages_malformed.yml', File.dirname(__FILE__)))
          }.to raise_error
        end
      end
    end
  end
end
