#!/usr/bin/env mzscheme
#lang scheme/base

(require (planet schematics/schemeunit:3)
         "syntax_transformer.ss")

; test the framework
(check-equal? #t #t "true is true")

(check-equal? 
 (transform-syntax (quote (foo bar baz))) 
 (quote (foo bar baz)))

(check-equal? 
 (transform-syntax (quote (foo.bar))) 
 (quote (__message_send__ foo (quote bar))))

(check-equal? 
 (transform-syntax (quote (bar.baz))) 
 (quote (__message_send__ bar (quote baz))))
