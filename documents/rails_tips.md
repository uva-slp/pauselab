## Rails tips

### Adding a new field to a database
1. generate a new migration `rails g migration`
2. add a change method with the statement `add_column <table_name>, <field_name>, <data_type>`
3. removing is similar `remove_column :ideas, :first_name, :string`

### Changing data type of a field 
1. generate a new migration
2. add statement in the change method `change_column <table_name>, <field_name>, <data_type>`
3. you can also use this to add *constraints* to the field e.g. if you were to add a not null constraint `change_column :table_name, :column_name, :column_type, null: false`
    + a more specific command to do the same thing `change_column_null :products, :name, false`

### Creating a table

1. `rails g model Name name:string`

```ruby
create_table :categories do |t|
  t.string :name, null: false
  t.timestamps
end
```

