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

    context "quando o usuario gostaria de autorizar uma chave" do
      context "tenta salvar uma chave que já está autorizada" do
        before do
          create :authorization, cpf: "02589041780", address: "39a008712649c0a7b2fcbb8310249f6a794b34cd"
        end
        it "Não deve criar uma autorizacao" do
          post :create, params: @params
        
          expect(response).to_not be_success
          expect(Authorization.count).to eq 1
          expect(parsed_response["msg"].first).to eq "Address Essa chave já foi autorizada"
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
        expect(parsed_response["msg"].first).to eq "Address O campo endereço é obrigatório"
      end
    end
  end

  describe "#destroy" do
    context "quando o usuário que revogar uma chave já autorizada" do
      before do
        create :authorization, cpf: "02589041780", address: "39a008712649c0a7b2fcbb8310249f6a794b34cd"
      end
      it "deve revogar a chave" do
        delete :destroy, params: {id: "39a008712649c0a7b2fcbb8310249f6a794b34cd"}
        expect(Authorization.count).to eq 0
      end
    end

    context "quando o usuário que revogar uma chave inexistente" do
      before do 
        create :authorization, cpf: "02589041780", address: "39a008712649c0a7b2fcbb8310249f6a794b34cd"
      end
      it "não deve revogar a chave" do
        delete :destroy, params: {id: "1111"}
        expect(Authorization.count).to eq 1
        expect(parsed_response["msg"]).to eq "Chave não encontrada"
      end
    end
  end
end