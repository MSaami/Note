# Note-Application

This is Note application that you can store your note on that, also you can attach file to each note.

## Install

- after clone the project run `bundle install`
- run `bin/rails db:migrate RAILS_ENV=development`
- run `db:seed` to prepare data
- run `rails server`

###Note
Active storage stores files in local driver, For changing driver to Amazon S3 you can change `development.rb` like below.
```
31   config.active_storage.service = :amazon
```
Since of sanctions I couldn't upload file into S3 and I used `fakes3` to simulate that situation.
Because of that the amazon's config in `storage.yml` is diffrent than usual.

## How to use Fakes3
- first install that gem with this command: `gem install fakes3`
- run `fakes3 -r /tmp/fakes3_root -p 4567 --license 5101872469`


## Credential
`email`: `test@gmail.com`
`password`: `123456`

you can use this credential to calling api.

## Login API

- With this api you can get JWT token for getting notes and folders, you have to set given token to headers as `Authorization` key .
URI: `{host}/api/v1/sessions`
Method: `POST`
Body: 
```
"login": {
    "email": "test@gmail.com"
        "password": "123456"
}
```
Success Response: `201`
Success Response Body: 
```
"token": "JWT Token"
```
Failed Response: `401`
Failed Response Body: 
```
{
    "error": "Your credentials are invalid"
}
```

## Notes API

**Create**
URI: `{host}/api/v1/notes`
Method: `POST`
Body:
Headers: `Authorization: Bearer <token>`
```
{
    "note":{
        "body": "This is body of note"
            "folder_id": "5",
            "file": "FILE
    }
}
```
Success Response: `201`
Validation Error Response: `422`
Validation Error Response Body: 
```
{
    "errors": {
        "body": [
            "can't be blank"
        ]
    }
}
```

**Index**
URI: `{host}/api/v1/notes`
Method: `GET`
Headers: `Authorization: Bearer <token>`
Response Code: `200`

**Update**
URI: `{host}/api/v1/notes/{note_id}`
Method: `PUT`
Body:
```
{
    "note":{
        "body": "This is body of note"
            "folder_id": "5",
            "file": "FILE
    }
}
```
Success Response Code: `204`

**Destroy**
URI: `{host}/api/v1/notes/{note_id}`
Method: `Delete`
Headers: `Authorization: Bearer <token>`
Success Response Code: `204`


## Folder API

**Create**
URI: `{host}/api/v1/folders`
Method: `POST`
Headers: `Authorization: Bearer <token>`
Body: 
```
"folder": {
    "name: "Folder Name"
}
```
Success Response Code: `201`
Validation Error Response: `422`
Validation Error Response Body: 
```
{
    "errors": {
        "name": [
            "can't be blank"
        ]
    }
}
```

**Index**
URI: `{host}/api/v1/folders`
Method: `GET`
Headers: `Authorization: Bearer <token>`
Success Response Code: `200`




