# Public Id

## Description

Simplifies the generation and use of random, secure ID's in your activerecord models.

## Usage

Add an additional identifier column. I called it "ident", but call it whatever you want.
```sh
# Identifier column MUST be a string
rails generate migration add_ident_to_users ident:string
```

Tell your activerecord object that ident is your new public identifier.
```ruby
class User < ActiveRecord::Base
  publically_identified_by :ident
  # Automatically defines to_param as :ident
end
```

Now change your controllers to lookup the public ID instead of your database ID
```ruby
class UserController < ApplicationController
  def show
    User.find_by_public_id(params[:id])
    # Or User.find_by_ident(params[:id])
    # Nothing fancy here
  end
end
```

There's a few other convenience methods that you may find useful.

 * Initialize ID's for existing records, useful in a migration.

    ```ruby
      def change
        add_column :users, :ident, :string
        User.initialize_public_ids!
      end
    ```
  * Get a new random ID for your own nefarious purposes:

  ``` User.new_public_identifier ```

### Configuration

By default, ID's have 2 components.
A 3 character lowercase prefix of their originating class name and a suffix of a 14 character random, unique, base64 url safe string.
The suffix and prefix are joined by a dash.

You can configure them using the following:

```ruby
  publically_identified_by column_name, variable_length: 10, prefix: false
  publically_identified_by other_column_name, variable_length: 15, prefix: 'user_'
```

# Contribute

  * Fork this project
  * Add tests
  * Submit a pull request

This project rocks and uses MIT-LICENSE.
