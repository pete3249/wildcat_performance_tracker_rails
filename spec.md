## Specifications for the Rails Assessment

Specs:
[x] Using Ruby on Rails for the project
[x] Relationships
    [x] Include at least one has_many relationship
    [x] Include at least one belongs_to relationship
    [x] Include at least two has_many through relationships
    [x] Include at least one many-to-many relationship 
  
``` rb
class User < ApplicationRecord
  has_many :performance_tests
  has_many :students, through: :performance_tests
  has_many :test_types, through: :performance_tests
end

class Student < ApplicationRecord
    has_many :performance_tests, :dependent => :destroy
    has_many :users, through: :performance_tests
    has_many :test_types, through: :performance_tests
end 

class TestType < ApplicationRecord
    has_many :performance_tests
end 

class PerformanceTest < ApplicationRecord
    belongs_to :user
    belongs_to :student
    belongs_to :test_type
end 
```

[x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user

 ```rb
 create_table "performance_tests", force: :cascade do |t|
    t.string "notes"
    t.float "result"
    t.datetime "date_taken"
    t.integer "user_id", null: false
    t.integer "student_id", null: false
    t.integer "test_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_performance_tests_on_student_id"
    t.index ["test_type_id"], name: "index_performance_tests_on_test_type_id"
    t.index ["user_id"], name: "index_performance_tests_on_user_id"
  end
```
 
[x] Include reasonable validations for simple model objects.

```rb
class User < ApplicationRecord
    validates :full_name, presence: true
end

class Student < ApplicationRecord
    validates :name, :grad_year, presence: true
    validates :name, uniqueness: { scope: [:grad_year], message: "and graduation year match an existing student"}
end 

class TestType < ApplicationRecord
    validates :name, presence: true, uniqueness: true
end 

class PerformanceTest < ApplicationRecord
    validates :result, :date_taken, presence: true
    validates :result, uniqueness: { scope: [:date_taken, :test_type, :user_id], message: "Performance test has already been recorded for this student."}
end
```

[x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)

```rb
class PerformanceTest < ApplicationRecord
  
  def self.by_test_type(test_type)
    where(test_type: test_type)
  end 
  URL: '/performance_tests'

  def self.latest
    order(date_taken: :desc).first
  end 
  URL: '/students'

  def self.most_recent
    order(date_taken: :desc)
  end 
  URL: '/performance_tests'

  def self.old
    order(date_taken: :asc)
  end
  URL: '/performance_tests'

  def self.top_scores
    order("result DESC").limit(3)
  end 
  URL: '/test_types/:test_type_id'

  def self.top_sprinting_scores
    order("result ASC").limit(3)
  end 
  URL: '/test_types/:test_type_id'

  def self.filter_options(options)
    if options[:filter_by_type] == "vertical"
        results = self.by_test_type(1)
    elsif options[:filter_by_type] == "broad" 
        results = self.by_test_type(2)
    elsif options[:filter_by_type] == "40" 
        results = self.by_test_type(3)
    elsif options[:filter_by_type] == "shuttle"
        results = self.by_test_type(4)
    else
        results = self.all
    end

    if options[:sort] == "most_recent"
        results = results.most_recent
    elsif options[:sort] == "old"
        results = results.old
    end 
    results
  end
  URL: '/performance_tests'

  def self.filter_tests(options)
    if options[:id] == "1" || options[:id] == "2"
        tests = self.top_scores
    elsif options[:id] == "3" || options[:id] == "4"
        tests = self.top_sprinting_scores
    end 
    tests
  end 
  URL: '/test_types/:test_type_id'

end
```

[x] Include signup, login, and logout: I used the github/devise documentation to configure devise for sign up, sign in, and logout. 

```rb
<h2>Sign Up</h2>

<%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  <%= render "devise/shared/error_messages", resource: resource %>

  <div class="field">
    <%= f.label :full_name %><br />
    <%= f.text_field :full_name %>
  </div>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
  </div>

  <div class="field">
    <%= f.label :password %>
    <% if @minimum_password_length %>
    <em>(<%= @minimum_password_length %> characters minimum)</em>
    <% end %><br />
    <%= f.password_field :password, autocomplete: "new-password" %>
  </div>

  <div class="field">
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation, autocomplete: "new-password" %>
  </div>

  <div class="actions">
    <%= f.submit "Sign up" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>

<h2>Log In</h2>

<%= form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
  </div>

  <div class="field">
    <%= f.label :password %><br />
    <%= f.password_field :password, autocomplete: "current-password" %>
  </div>

  <% if devise_mapping.rememberable? %>
    <div class="field">
      <%= f.check_box :remember_me %>
      <%= f.label :remember_me %>
    </div>
  <% end %>

  <div class="actions">
    <%= f.submit "Log in" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>
```

[x] Include third party signup/login: I used OmniAuth and devise for Oauth. Since my users are teachers/coaches who all have school emails, I decided to use google for authorization.

[x] Include nested resource show or index and nested resource "new" form

config/routes.rb
```rb
resources :students do
    resources :performance_tests, only: [:index, :new, :show]
end 

student_performance_test_path '/students/:student_id/performance_tests' (performance_tests - index)
new_student_performance_test_path '/students/:student_id/performance_tests/new' (performance_tests - new)
student_performance_test_path '/students/:student_id/performance_tests/:id' (performance_tests - show)
```

[x] Include form display of validation errors (form URL e.g. /recipes/new)

views/performance_tests/new.html.erb
```rb
<h1>New Performance Test</h1>
<%= render partial: 'form', locals: { performance_test: @performance_test } %>
```

views/performance_tests/_form.html.erb
```rb
<%= form_for performance_test do |f|%>
    <%= show_errors_for(performance_test)%>
    
    <div>
        <%= f.label :student_id, "Student:" %>
        <%= f.collection_select :student_id, Student.all, :id, :name, prompt: true %>
    </div>

    <div>
        <%= f.label :test_type_id, "Test Type:" %>
        <%= f.collection_select :test_type_id, TestType.all, :id, :name, prompt: true %>
    </div>

    <div>
        <%= f.label :notes, "Notes:" %>
        <%= f.text_field :notes %>
    </div>

    <div>
        <%= f.label :result, "Result:" %>
        <%= f.text_field :result %>
    </div>

    <div>
        <%= f.label :date_taken, "Date:" %>
        <%= f.date_select :date_taken %>
    </div>

    <%= f.submit %>
<% end %>
```

views/shared/error_messages.html.erb
```rb
<% if resource.errors.any? %>
  <div id="error_explanation">
    <h2>
      <%= I18n.t("errors.messages.not_saved",
                 count: resource.errors.count,
                 resource: resource.class.model_name.human.downcase)
       %>
    </h2>
    <ul>
      <% resource.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
    </ul>
  </div>
<% end %>
```

Confirm:
[x] The application is pretty DRY
[x] Limited logic in controllers
[x] Views use helper methods if appropriate
[x] Views use partials if appropriate