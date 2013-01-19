require "spec_helper"
include Capybara::DSL

describe 'TranslateRoutes' do

  let(:page_title){ "dummy page" }
  let(:page_title_with_url){ "dummy page with url" }
  let(:page){ Factory.create :page, title: page_title }
  let(:page_with_url){ Factory.create :page, title: page_title_with_url }

  before {
    Refinery::PagesController.any_instance.stub(:refinery_user_required?).and_return(false)
   }

  context "routing" do

    context "when visit page with default path" do

      before { visit "/pages/#{page.slug}" }

      it { page.should_not have_content("Page not found") }
      it { page.should_not have_content("The page you were looking for doesn't exist.") }
      it { page.should have_xpath("//section[@id='page']//section//h1[@id='body_content_title']", text: page_title) }
      it { page.should have_xpath("//nav[@id='menu' and @class='menu']//ul//li//a[@href='/#{page.slug}']", text: page_title) }

    end

    context "when visit page with translated path" do

      before { visit "/es/paginas/#{page.slug}" }

      it { page.should_not have_content("Page not found") }
      it { page.should_not have_content("The page you were looking for doesn't exist.") }
      it { page.should have_xpath("//section[@id='page']//section//h1[@id='body_content_title']", text: page_title) }
      it { page.should have_xpath("//nav[@id='menu' and @class='menu']//ul//li//a[@href='/es/#{page.slug}']", text: page_title) }

    end

    context "when using url helpers" do
      context "when visit page with default path" do

        before do
          I18n.locale = :en
          visit "/pages/#{page_with_url.slug}"
        end

        it { page.should have_content("/pages/#{page_with_url.slug}") }

      end

      context "when visit page with translated path" do

        before do
          I18n.locale = :es
          visit "/es/paginas/#{page_with_url.slug}"
        end

        it { page.should have_content("/es/paginas/#{page_with_url.slug}") }

      end
    end
  end
end
