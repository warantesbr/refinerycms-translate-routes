require "spec_helper"
include Capybara::DSL

describe 'TranslateRoutes' do

  let(:page_title){ "dummy page" }
  let(:page){ Factory.create :page, title: page_title }

  before { Refinery::PagesController.any_instance.stub(:refinery_user_required?).and_return(false) }

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
  end
end
