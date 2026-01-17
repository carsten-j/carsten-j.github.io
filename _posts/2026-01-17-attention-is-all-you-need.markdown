---
layout: post
title: Hvordan virker attention i sprogmodeller
date: '2026-01-17 13:14:43'
---

Jeg læser Sebastian Raschkas vidunderlige bog [Build a Large Language Model (From Scratch)](https://www.amazon.com/Build-Large-Language-Model-Scratch/dp/1633437167) og er i gang med kapitlet om Attention.

For at forstå attention skal du som minimum have en basal viden om sprogmodeller og mere specifikt bør du kende til begreberne tokenizer og embeddings.

Attention er det der gør moderne sprogmodeller som ChatGPT og Claude så kraftfulde. Det er mekanismen der tillader modellen at forstå sammenhænge mellem ord - uanset hvor langt fra hinanden de står i teksten. Forstår du attention, forstår du kernen i hvordan disse modeller virker.

Dette bliver ikke "endnu en blog-post" om attention, da der allerede findes mange gode derude. Til gengæld giver jeg dig en kurateret liste over resourcer, som jeg fandt nyttige i forsøg på at forstå attention mekanismen.

Den oprindelige artikel [Attention Is All You Need](https://arxiv.org/abs/1706.03762) er faktisk til at læse, men måske ikke stedet at starte med mindre du er vant til at læse videnskabelige artikler. Der findes også en [annoterede udgave](https://nlp.seas.harvard.edu/annotated-transformer/), som har den fordel, at der også er kode med. Så hvis du lære ved at læse kode, så kunne det være et godt sted at starte.

Er du mere til video så har fantastiske [3Blue1Brown](https://www.youtube.com/@3blue1brown) denne her [video](https://www.youtube.com/watch?v=eMlx5fFNoYc) som har mere fokus på ideer og intuition end på kode.

Har du brug for et lidt mere overordnet perspektiv så kig [her](https://jalammar.github.io/illustrated-transformer/). Denne blog post er siden blevet et kapitel i bogen [Hands-On Large Language Models](https://www.llm-book.com/).

For at forstå Q, K, og V matricerne kan du læse videre [her](https://arpitbhayani.me/blogs/qkv-matrices) og [her](https://towardsdatascience.com/deep-dive-into-self-attention-by-hand-%EF%B8%8E-f02876e49857/). De sidste to referencer er også et godt sted at starte, hvis du vil være klogere på [prompt caching](https://ngrok.com/blog/prompt-caching/).
