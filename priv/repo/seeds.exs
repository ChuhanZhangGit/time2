# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timesheets.Repo.insert!(%Timesheets.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Time2.Repo
alias Time2.Users.User
alias Time2.Daysheets.Daysheet
alias Time2.Jobs.Job
alias Time2.Tasks.Task

manager_pw = Argon2.hash_pwd_salt("1")
worker_pw = Argon2.hash_pwd_salt("1")
IO.puts(manager_pw)
Repo.insert!(%User{id: 1, group: "manager", name: "Alice", email: "alice@example.com", password_hash: manager_pw})
Repo.insert!(%User{id: 5, group: "manager", name: "test", email: "test", password_hash: manager_pw})

Repo.insert!(%User{id: 2, group: "worker", manager_id: 1, name: "Bob", email: "bob@example.com", password_hash: worker_pw})
Repo.insert!(%User{id: 3, group: "worker", manager_id: 1, name: "Carol Anderson", email: "carol@example.com", password_hash: worker_pw})
Repo.insert!(%User{id: 4, group: "worker", manager_id: 5, name: "Dave Anderson", email: "dave@example.com", password_hash: worker_pw})

Repo.insert!(%Daysheet{id: 1, manager_id: 5, worker_id: 2, date: ~D[2000-01-01], approved: false })

Repo.insert!(%Job{id: 1, jobcode: "1234", manager_id: 5, name: "test_job1", description: "new job"})

Repo.insert!(%Job{id: 2, jobcode: "2345", manager_id: 5, name: "test_job2", description: "new job"})

Repo.insert!(%Task{note: "new note", daysheet_id: 1, job_id: 1, job_code: "1234", worker_id: 2, hours: 2.0})