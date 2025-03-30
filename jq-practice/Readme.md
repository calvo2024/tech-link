# jq Practice 

Welcome to the **jq Practice **! Designed to help you learn and practice using `jq`, a powerful command-line tool for processing and querying JSON data.

Some of the exercises in this repository are inspired by [this blog post](https://ishan.page/blog/2023-11-06-jq-by-example/#selecting-values) by Ishan, which provides excellent examples and use cases for `jq`.

## Repository Structure

The repository is organized into the following folders:

- **`exercises/`**: This folder contains JSON files with questions and challenges. Each file presents a JSON dataset and a set of tasks or queries to perform using `jq`.
- **`answers/`**: This folder contains the correct `jq` commands and their expected outputs for the exercises in the `exercises/` folder.

## What is jq?

`jq` is a lightweight and flexible command-line JSON processor. It allows you to parse, filter, map, and transform JSON data with ease. Think of it as `sed` or `awk` but specifically designed for JSON.

### Key Features of jq:
- Extract specific fields or values from JSON.
- Perform complex filtering and transformations.
- Combine and manipulate JSON objects and arrays.
- Format JSON output for readability.

## How to Use jq

To use `jq`, you need to install it on your system. You can find installation instructions on the [official jq website](https://stedolan.github.io/jq/).

Once installed, you can run `jq` commands in your terminal. Here's a basic example:

```bash
echo '{"name": "Alice", "age": 25}' | jq '.name'
```

Output:
```
"Alice"
```

In this example, `jq '.name'` extracts the value of the `name` field from the JSON object.

## How to Use This Repository

1. Navigate to the `exercises/` folder and pick a JSON file to work on.
2. Use `jq` to solve the queries or tasks described in the file.
3. Compare your results with the solutions in the `answers/` folder to check your understanding.

## Contributing

Feel free to contribute by adding new exercises or improving existing ones. Make sure to update the corresponding answers in the `answers/` folder.

Happy learning and happy querying with `jq`!