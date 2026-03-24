# Hello, Docker!

Docker set up tutorial for getting acquaintaned with containerization. Project: [https://roadmap.sh/projects/basic-dockerfile](https://roadmap.sh/projects/basic-dockerfile)

## Overview

This project builds a lightweight container using `alpine:latest` that prints a greeting:

* Defaults to: `Hello, Captain!`
* Accepts an optional argument: `Hello, <name>!`

## Prerequisites

* Docker installed

## Build

```bash
docker build -t hello-cli .
```

## Run

**Default:**

```bash
docker run hello-cli
```

Output:

```
Hello, Captain!
```

**With a name:**

```bash
docker run hello-cli Alice
```

Output:

```
Hello, Alice!
```

## Project Structure

```
.
├── Dockerfile
└── README.md
```
