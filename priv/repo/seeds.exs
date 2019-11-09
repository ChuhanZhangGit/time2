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


Repo.insert!(%Job{id: 1, jobcode: "job1", manager_id: 5, name: "test_job1", description: "new job"})

Repo.insert!(%Job{id: 2, jobcode: "job2", manager_id: 5, name: "test_job2", description: "new job"})
Repo.insert!(%Job{id: 3, jobcode: "job3", manager_id: 1, name: "test_job1", description: "new job"})
Repo.insert!(%Job{id: 4, jobcode: "job4", manager_id: 1, name: "test_job2", description: "new job"})
