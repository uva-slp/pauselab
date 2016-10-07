## Rails tips

### Adding/removing a new field to a table
1. generate a new migration `rails g migration`
2. add a change method with the statement `add_column :table, :column, :type`
3. removing is similar `remove_column :ideas, :first_name, :string`

### Changing data type of a field 
1. generate a new migration
2. add statement in the change method `change_column :table, :column, :type`
3. you can also use this to add *constraints* to the field e.g. if you were to add a not null constraint 
`change_column :table_name, :column_name, :column_type, null: false`
    + a more specific command to do the same thing 
    `change_column_null :products, :name, false`

### Creating a table

`rails g model Name name:string`

```ruby
create_table :table_name do |t|
  t.type :column, null: false
  t.timestamps # auto generated fields relating to time
end
```

### Creating a many to many relationship 
There are two major way of creating many to many relationship in rails; first is with the **join model** and second is with the **join table**. The join model should be used if you want to use the relationship as a 
separate entity i.e. have its own attributes. The join table should be used if you want a direct many to many 
relationship and don't need a relationship entity (this is much simpler).

For the examples below lets make a showtimes relationship between a theater and a movie

#### Join model 
Generate a join model - `rails g model showtime` 

This model's table should contain two integer columns for the two connected models

```ruby
def change
	create_table :showtimes do |t|
		t.integer :theater_id
		t.integer :movie_id
		# more fields if needed
	  	t.timestamps
	end
end
```

Now declare the relationship in the model classes

```ruby
# models/movie.rb
class Movie < ActiveRecord::Base
  has_many :showtimes
  has_many :theaters, through: :showtimes
end

# models/theater.rb
class theater < ActiveRecord::Base
  has_many :showtimes
  has_many :movies, through: :showtimes
end

# models/showtime.rb
class ShowTime < ActiveRecord::Base
  belongs_to :movie
  belongs_to :theater
end
```

#### Join table
Generate a join table migration - `rails g migration create_join_table movie theater`

This should create the following migration:

```ruby
def change
  create_join_table :movies, :theatres do |t|
    # t.index [:movie_id, :theatre_id]
   	# t.index [:theatre_id, :movie_id]
  end
end
```

Now declare the relationship in the model classes:

```ruby
# models/movie.rb
class Movie < ActiveRecord::Base
  has_and_belongs_to_many :theatres
end

# models/theatre.rb
class Theatre < ActiveRecord::Base
  has_and_belongs_to_many :movies
end
```



