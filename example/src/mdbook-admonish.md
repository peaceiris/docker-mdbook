# mdbook-admonish

[tommilligan/mdbook-admonish: A preprocessor for mdbook to add Material Design admonishments.](https://github.com/tommilligan/mdbook-admonish)


## Installation

```sh
docker run --rm -i -t -v "./example:/book" --entrypoint sh "peaceiris/mdbook:v0.4.40-arm64"
mdbook-admonish install /book
```

`book.toml`

```toml
[preprocessor.admonish]
command = "mdbook-admonish"
assets_version = "3.0.2" # do not edit: managed by `mdbook-admonish install`

[output.html]
additional-css = ["mdbook-admonish.css", "/book/mdbook-admonish.css"]
```


## Examples

```admonish info
A beautifully styled message.
```

```admonish example
My example is the best!
```

```admonish
A plain note.
```

```admonish warning title="Data loss"
The following steps can lead to irrecoverable data corruption.
```

```admonish tip title='_Referencing_ and <i>dereferencing</i>'
The opposite of *referencing* by using `&` is *dereferencing*, which is
accomplished with the <span style="color: hotpink">dereference operator</span>, `*`.
```

~~~admonish bug
This syntax won't work in Python 3:
```python
print "Hello, world!"
```
~~~

```admonish title="Sneaky", collapsible=true
Content will be hidden initially.
```
