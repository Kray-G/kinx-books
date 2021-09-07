
# Introduction

## What is Kinx?

Ruby and Python are two of the most popular and major scripting languages in the world.
Each language has a large number of users and is used in many situations to solve real world problems.
But neither of them is C-like, why?

Moreover, statically typed languages, which are said to be more secure, are popular more and more these days.
However, a dynamically typed language should be a very usable tool that can be more productive as long as skills are enough[^highskill].
When it is a C-style syntax, we have the option of node.js with JavaScript or TypeScript,
but node.js is not lightweight at all.
Besides, the event loop mechanism is difficult to use as a scripting language.

[^highskill]: Especially in large-scale development, people will doubt that "as long as skills are enough" part. That is the reason why statically typed languages are popular.

That is why this project was started as we hope the scripting language with the same purpose as Ruby and Python,
and which has the charactaric of a dynamically typed language and a C-like syntax and easy to use.

In short, to put Kinx in a sentense, **it is a script language with a traditional C-style syntax fitting in a programmer\\apos{}s hand.**

But Kinx also has a simple Type Annotation feature.
Only when Kinx can handle it, but it will indicate an error by Type Annotation in the case when it find some clearly unexpected mismatches between types.
See ''\\nameref{Type Annotation}'' for details.

## Kinx Features

### The Concept

The concept of Kinx is, **Looks like JavaScript, feels like Ruby, and it is a script language fitting in C programmers.**

We hope, it looks like JavaScript, and its feeling of use are flexible such as a Ruby,
and also it is a scripting language fitting in many C programmers who are familiar with a C like syntax.
If you are a C programmer, Kinx is more comfortable than Ruby and Python, and you can get the feeling of very fitting in your hand.

### Main Features

Kinx is a **dynamically typed language** and an **object oriented programming language.**
The main features are below.

* Dynamically Typed Language, but also supporting Type Annotation.
* Object Oriented Programming Language.
* C Like Syntax, it\\apos{}s almost JavaScript.
* Class and Inheritance, Module and Mix-in, and Fiber.
* Higher Order Functions, Lexical Scopes, and Closures.
* Memory Management by GC.
* `native` function compiled by JIT.

### About This Document

This document is the first book to sum up the Programming Language Kinx.
It is planned to cover all functionalities to be supported, but it may be changed in the future.
Please be aware of it in advance.
By the way, the resource information is described in Appendex, see the link for the latest information.
