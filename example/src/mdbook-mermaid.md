# mdbook-mermaid

[mdbook-mermaid]

[mdbook-mermaid]: https://github.com/badboy/mdbook-mermaid


## Installation

```sh
docker run --rm -i -t -v "./example:/book" --entrypoint sh "peaceiris/mdbook:v0.4.40-arm64"
mdbook-mermaid install /book
```

`book.toml`

```toml
[preprocessor.mermaid]
command = "mdbook-mermaid"

[output.html]
additional-js = ["mermaid.min.js", "mermaid-init.js"]
```


## Example

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
