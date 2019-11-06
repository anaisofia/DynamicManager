ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation, :phone, :superadmin

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :user_since do |user|
      time_ago_in_words(user.created_at)
    end
    actions
  end

  filter :email
  # filter :superadmin, as: :check_boxes
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :phone
      f.input :password
      f.input :password_confirmation
      f.input :superadmin
    end
    f.actions
  end

  #Allows updating a user profile without changing his password
  controller do
    def update
      if (params[:user][:password].blank? && params[:user][:password_confirmation].blank?)
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end

end
