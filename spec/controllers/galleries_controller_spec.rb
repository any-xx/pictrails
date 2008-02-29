require File.dirname(__FILE__) + '/../spec_helper'

describe 'GalleriesController first login without gallery' do
  controller_name :galleries

  before(:each) do
    User.delete_all
  end

  it 'should redirect to signup in index galleries' do
    get 'index'
    response.should redirect_to(admin_signup_url)
  end

  it 'should redirect to signup in show galleries' do
    #gallery1 is a permalink of a gallery exist
    get 'show', :id => 'gallery1'
    response.should redirect_to(admin_signup_url)
  end
end

describe 'GalleriesController there are a user' do
  controller_name :galleries
  fixtures :users, :galleries, :pictures, :thumbnails

  it 'should be not redirect to signup' do
    get 'index'
    response.should_not redirect_to(admin_signup_url)
  end
  
  it 'should be not redirect to signup in show galleries' do
    get 'show', :id => galleries(:gallery1).permalink
    response.should_not redirect_to(admin_signup_url)
  end
  
  it 'should be redirect_to gallery list because no gallery with this id' do
    get 'show', :id => 'unknowgallery'
    response.should redirect_to(galleries_url)
  end

  it 'should be redirect_to gallery list because gallery status is disabled' do
    get 'show', :id => galleries(:gallery2).permalink
    response.should redirect_to(galleries_url)
  end

end