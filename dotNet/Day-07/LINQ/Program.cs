
using EntityProject.Data;
using Microsoft.EntityFrameworkCore;
using EntityProject.Models.Entities;
//using System;
//using System.Collections.Generic;
using System.Linq;
using System;
namespace EntityProject
{
    public class Program
    {
        public static void Main(string[] args)
        {

            List<Person> People = new List<Person>
            {
                new Person {name="Villu",age=34},
                new Person{name="Minno",age=23},
                new Person{name="Rama",age=45},
                new Person{name="Raama",age=35}
            };
            //var olderPeopleQuery = from p in People
            //                       where p.age > 28
            //                       orderby p.name
            //                       select p;

            //foreach (var person in olderPeopleQuery)
            //{
            //    Console.WriteLine(person.name + person.age);
            //}


            //var nameStartWithR = from p in People
            //                     where p.name.StartsWith("R%")
            //                     select p;
            //foreach(var person in nameStartWithR) {
            //    Console.WriteLine(person.name);
            //}


            //var specificPerson = from p in People
            //                     select p.name;

            //var top10 = People.Take(10).ToList();

            var Customer = People
                           .Where(c => c.name == "Rama")
                           .ToList();


            foreach (var person in Customer)
            {
                Console.WriteLine(person.name);
            }



            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            builder.Services.AddDbContext<ApplicationDbContext>(options =>
            options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));


            //add by me

            //options.UseS




            var app = builder.Build();

            // Configure the HTTP request pipeline.
            //if (app.Environment.IsDevelopment())
            //{
            //    app.UseSwagger();
            //    app.UseSwaggerUI();
            //}

            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
