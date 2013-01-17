open util/relation

sig NAME {}
sig DATE {}

sig BirthdayBook {
  known: NAME,
  birthday : NAME -> lone DATE
} {
  known = dom[birthday]
}

pred AddBirthday [book,book':BirthdayBook, name:NAME, date:DATE] {
  name not in book.known
  book'.birthday = book.birthday + name -> date
}

pred FindBirthday [book:BirthdayBook, name:NAME, date:DATE] {
  name in book.known
  date = book.birthday[name]
}

pred Remind [book:BirthdayBook, today:DATE, cards : set NAME] {
  cards = { n: book.known | book.birthday[n] = today}
}

pred InitBirthdayBook [book:BirthdayBook] {
  book.known = none
}

enum REPORT {ok,already_known,not_known}
pred Success [result:REPORT] {
  result = ok
}

pred AlreadyKnown [book:BirthdayBook,name:NAME,result:REPORT] {
  name in book.known
  result = already_known
}

pred RAddBirthday [book,book':BirthdayBook,name:NAME,date:DATE,result:REPORT] {
  (name not in book.known and
    book'.birthday = book.birthday + name->date and
    result = ok) or
  (name in book.known and
    book'.birthday = book.birthday and
    result = already_known)
}

run {} for 3 NAME, 3 DATE, 3 BirthdayBook
