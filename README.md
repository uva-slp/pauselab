# Pauselab

A system to manage community engagement in proposing and selecting public art projects.

Prioritites:
immediate, very-high, high, medium, low, very-low, unknown

Story Points (Fibbionacci):
0, 1, 2, 3, 5, 8, 13

Schema:
------


Idea:
+ first_name: string
+ last_name: string
+ phone: string
+ description: text
+ location: string
+ category: category_id
+ status: boolean 
+ likes: integer


Project: 
...


Category:
+ id: int
+ name: string


Proposal
+ artist: artist_id (foreign key)
+ idea: idea_id (foreign key)
+ cost_estimate: int
+ description: text
+ essay: file
+ status: boolean 


Artist 
+ first_name: string
+ last_name: string
+ email: string
+ phone: string
+ proposals_submitted: proposals submitted
+ current_project: project
+ password: password


User
+ first_name: string
+ last_name: string
+ email: string
+ phone: string
+ password: password


Role
+ user: user_id
+ type: string



<!--   <% if @idea.errors.any? %>
    <div id="error_explanation" class="alert alert-danger">
      <strong>
        <%= pluralize(@idea.errors.count, "error") %> prohibited
        this article from being saved:
      </strong>
      <ul>
        <% @idea.errors.full_messages.each do |msg| %>
          <li><%= msg %></li>
        <% end %>
      </ul>
    </div>
  <% end %> -->


  ```html
  <ol class="breadcrumb">
    <li class="active">home</li>
    <li><a href="">about</a></li>
    <li class="dropdown">
      <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
        get involved <!-- <span class="caret"></span> -->
      </a>
      <ul class="dropdown-menu multi-level">
         <li><a href="#">submit an idea</a></li>
      </ul>
    </li>
    <li><a href="">contact</a></li>
    <% if user_signed_in? %>
    <li class="pull-right"><%= link_to "logout", destroy_user_session_path, :method => :delete %></li>
    <% else %>
    <li class=""><%= link_to "login", new_user_session_path %></a>
    <li class=""><%= link_to "sign up", new_user_registration_path %></a>
    <% end %>
  </ol>

  ```
