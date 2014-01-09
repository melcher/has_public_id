= Public Id

== Description

Simplifies the generation and use of random, secure ID's in your activerecord models.

== Usage

```sh
# Identifier column MUST be a string
rails generate migration add_ident_to_users ident:string
```

```ruby app/models/user.rb
class User < ActiveRecord::Base
  publically_identified_by :ident
  # Automatically defines to_param as :ident
end
```
```ruby app/controllers/user_controller.rb
class UserController < ApplicationController
  def show
    User.find_by_public_id(params[:id])
    # Or User.where(ident: params[:id])
    # Nothing fancy here
  end
end
```

There's a few other convenience methods that you may find useful.
```ruby
  User.initialize_public_ids! 
  # Sets public_id's on any resources with nil public_ids.
  # Useful when migrating existing records
```

=== Configuration

By default, ID's have 2 components.
A 3 character lowercase prefix of their originating class name and a suffix of a 14 character random, unique, base64 url safe string.
The suffix and prefix are joined by a dash.

You can configure them using the following:

```ruby
  publically_identified_by column_name, variable_length: 10, prefix: false
  publically_identified_by other_column_name, variable_length: 15, prefix: 'user_'
```

= Contribute

  * Fork this project
  * Add tests
  * Submit a pull request

This project rocks and uses MIT-LICENSE.
