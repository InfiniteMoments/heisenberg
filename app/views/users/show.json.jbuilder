json.(@user, :id, :name, :username)
json.email @user.email if current_user?(@user)