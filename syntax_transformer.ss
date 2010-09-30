#lang scheme/base

(define list-contains-char?
  (lambda (lst search)
    (cond
     ((null? lst) #f)
     ((equal? (car lst) search) #t)
     (else
      (list-contains-char? (cdr lst)
                           search)))))

(define string->split
  (lambda (str token)
    (let ((chars (string->list str)))
      (letrec
          ((f (lambda (before after)
                (cond
                 ((null? after)
                  (list before after))
                 ((equal? (car after) token)
                  (list before
                        (cdr after)))
                 (else
                  (f (cons (car after)
                           before)
                     (cdr after)))))))
        (let ((x (f '() chars)))
          (list
           (list->string (reverse (car x)))
           (cdr x)))))))

(define split_obj_and_args
  (lambda (obj_and_args)
    (string->split obj_and_args #\.)))

(define transform-syntax
  (lambda (syntax)
    (cond
     ((list-contains-char? (string->list (symbol->string (car syntax)))
                           #\.)
      (let ((sym_and_args (split_obj_and_args (symbol->string (car syntax)))))
        
        (cons
         (quote __message_send__)
         (cons
          (string->symbol (car sym_and_args))
          (cons
           (cdr sym_and_args)
           '())))))
     (else
      syntax))))

(provide transform-syntax)