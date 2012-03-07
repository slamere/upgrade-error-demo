require File.dirname(__FILE__) + '/../test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organization" do
    assert_difference('Organization.count') do
      post :create, :organization => { }
    end

    assert_redirected_to organization_path(assigns(:organization))
  end

  test "should show organization" do
    get :show, :id => organizations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => organizations(:one).to_param
    assert_response :success
  end

  test "should update organization" do
    put :update, :id => organizations(:one).to_param, :organization => { }
    assert_redirected_to organization_path(assigns(:organization))
  end

  test "should update organization with phone" do
    org = organizations(:org_with_phone)
    phone = phones(:phone_for_org)
    

    # make sure our phone/org objects are valid for this test
    assert_equal 1, org.phones.size, "We need to start with 1 phone"
    assert_equal phone, org.phones.first, "We need to start with the right phone"

    put :update, {:id => org.to_param,
                  :organization => {:name => "Test Organization Name",
                                    :phones_attributes => {0 => { :number => "888-9955",
                                                                  :id => phone.id}}}}

    # check org saved
    assert flash[:notice] == 'Organization was successfully updated.'

    # check that everything changed
    org.reload
    phone.reload

    assert_equal "Test Organization Name", org.name, "Name should have changed"
    assert_equal 1, org.phones.size, "We should only have 1 phone for this org."
    assert_equal "888-9955", phone.number, "Phone should have changed"
  end

  test "should destroy organization" do
    assert_difference('Organization.count', -1) do
      delete :destroy, :id => organizations(:one).to_param
    end

    assert_redirected_to organizations_path
  end
end
