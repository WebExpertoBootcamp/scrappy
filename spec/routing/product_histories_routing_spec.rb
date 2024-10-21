require "rails_helper"

RSpec.describe ProductHistoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/product_histories").to route_to("product_histories#index")
    end

    it "routes to #new" do
      expect(get: "/product_histories/new").to route_to("product_histories#new")
    end

    it "routes to #show" do
      expect(get: "/product_histories/1").to route_to("product_histories#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/product_histories/1/edit").to route_to("product_histories#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/product_histories").to route_to("product_histories#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/product_histories/1").to route_to("product_histories#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/product_histories/1").to route_to("product_histories#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/product_histories/1").to route_to("product_histories#destroy", id: "1")
    end
  end
end
