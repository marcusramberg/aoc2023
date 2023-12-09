#lang racket

(define (sum lst)
  (foldl + 0 lst))

(define (differences lst)
  (if (or (null? lst) (null? (cdr lst)))  ; Check if the list is empty or has only one element
      '()                                 ; Return an empty list in that case
      (cons (- (second lst) (first lst))   ; Calculate the difference between the first two elements
            (differences (cdr lst)))))     ; Recursively call the function on the rest of the list
; find diffs
(define (find-diffs lst)
   (if (= (sum (last lst)) 0)
      lst
     {begin
    (find-diffs (append lst (list (differences (last lst)))))
    }
  ))

(define (inc-by-prev-first-elem lst)
    (begin (displayln lst)
    (foldr (lambda (sublist acc) (- (first sublist) acc)) 0 lst)))
    

(define (predict-next nums)
  (inc-by-prev-first-elem (find-diffs (list nums)))
)

(define total 0)
(with-input-from-file "input.txt"
                  (thunk 
                    (displayln(sum
                    (for/list ([line (in-lines)])
    (predict-next(map string->number (string-split line)))
    )))))
