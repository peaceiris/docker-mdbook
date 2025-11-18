# Admonitions (Built-in)

mdBook 0.5 has built-in support for admonitions using blockquote syntax.

[Admonitions - The mdBook Documentation](https://rust-lang.github.io/mdBook/format/markdown.html#admonitions)


## Examples

> [!NOTE]
> A beautifully styled message.

> [!TIP]
> My example is the best!

> [!NOTE]
> A plain note.

> [!WARNING]
> **Data loss**
>
> The following steps can lead to irrecoverable data corruption.

> [!TIP]
> **_Referencing_ and <i>dereferencing</i>**
>
> The opposite of *referencing* by using `&` is *dereferencing*, which is
> accomplished with the <span style="color: hotpink">dereference operator</span>, `*`.

> [!CAUTION]
> This syntax won't work in Python 3:
> ```python
> print "Hello, world!"
> ```

> [!NOTE]
> **Sneaky**
>
> Content will be hidden initially.
