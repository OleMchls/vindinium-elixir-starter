# Vindinium starterkit in Elixir

Learn about [Vindinium](http://vindinium.org/) first.

> Vindinium is an Artificial Intelligence programming challenge. You have to take the control of a legendary hero using the programming language of your choice. You will fight with other AI for a predetermined number of turns and the hero with the greatest amount of gold will win.

![](https://cl.ly/2m0Z2z0Q2a3p/Screen%20Shot%202016-10-08%20at%2021.12.37.png)

## Install dependencies

```bash
mix deps.get
```

## Run with:

```bash
mix run vindinium.exs <key> <[training|arena]> <number-of-turns>
```
### Examples
```bash
mix run vindinium.exs abc123 training 10
mix run vindinium.exs abc123 arena
```

## Own Vindinium Server

In case you want to play on your own [vindinium server](https://github.com/ornicar/vindinium), simply change the url in your `config.exs`:

```
config :vindinium, api_url: "http://vindinium.example.com/api/"
```
