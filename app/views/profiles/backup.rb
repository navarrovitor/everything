<% users = User.all %>

<% users.each do |user| %>
<p><%= cl_image_tag(current_user.photo, width: 150, height: 150, crop: :thumb, gravity: :face, class: "avatar") %> email: <%= user.email %> <a href="#" class="btn-red">Follow</a></p>
<% end %>
