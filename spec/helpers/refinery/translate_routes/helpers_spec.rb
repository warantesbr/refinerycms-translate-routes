require "spec_helper"

module Refinery
  describe "TranslateRoutes" do

    let(:host){ "test.host" }
    let(:page_title){ "dummy page" }
    let(:page){ Factory.create :page, title: page_title }

    context "helpers" do

      context "when locale is set to en" do

        before{ ::I18n.locale = :en }

        context "page path helper output" do
          it { refinery.page_path(page).should eq("/pages/#{page.slug}") }
        end

        context "page url helper output" do
          it { refinery.page_url(page).should eq("http://#{host}/pages/#{page.slug}") }
        end

      end

      context "when locale is set to es" do

        before{ ::I18n.locale = :es }

        context "page path helper output" do
          it { refinery.page_path(page).should eq("/es/paginas/#{page.slug}") }
        end

        context "page url helper output" do
          it { refinery.page_url(page).should eq("http://#{host}/es/paginas/#{page.slug}") }
        end

      end

    end
  end
end