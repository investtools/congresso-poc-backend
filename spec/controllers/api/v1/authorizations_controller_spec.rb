require "spec_helper"

describe Api::V1::AuthorizationsController, type: :controller do

  let(:parsed_response) { JSON.parse(@response.body) }

  describe "#create" do
    before do
      @params = {
        authorization: {
          cpf: "02589041780",
          address: "39a008712649c0a7b2fcbb8310249f6a794b34cd"
        }
      }
    end

    context "quando o usuario gostaria de autorizar uma chave" do
      context "e passa todos os dados corretamente" do
        it "deve criar uma autorizacao" do
          post :create, params: @params
          
          expect(response).to be_success
          expect(Authorization.count).to eq 1
          expect(Authorization.first.cpf).to eq "02589041780"
          expect(Authorization.first.address).to eq "39a008712649c0a7b2fcbb8310249f6a794b34cd"
        end
      end
    end

    context "e passa todos os dados incorretamente faltando o address" do
      before do
        @params = {
          authorization: {
            cpf: "02589041780"
          }
        }
      end
      it "não deve criar uma autorização" do
        post :create, params: @params
        expect(response).to_not be_success
        expect(Authorization.count).to eq 0
        expect(parsed_response["msg"].first).to eq "Address O campo address é obrigatório"
      end
    end
  end
end