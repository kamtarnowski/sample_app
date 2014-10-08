require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end

    describe 'as incorrect user' do

      let(:user2) { FactoryGirl.create(:user) }
      before do
        sign_in user2
        visit root_path
      end

      it 'should not delete other user micropost' do

        expect do
          delete micropost_path(Micropost.where(user: user))
        end.to change(Micropost, :count).by(0)

      end
    end
  end

  describe "micropost count" do
    describe "as new user" do
      before { visit root_path }
      it { should have_content('0 microposts') }
    end
    describe "with one micropost" do
      before do
        FactoryGirl.create(:micropost, user: user)
        visit root_path
      end
      it { should have_content(/1 micropost[^s]/) }
    end
    describe "with two microposts" do
      before do
        FactoryGirl.create(:micropost, user: user)
        FactoryGirl.create(:micropost, user: user)
        visit root_path
      end
      it { should have_content('2 microposts') }
    end
  end

  describe "micropost pagination" do

    before do
      50.times { FactoryGirl.create(:micropost, user: user)}
      visit root_path
    end

    it {should have_selector('div.pagination', maximum: 30)}
  end
end