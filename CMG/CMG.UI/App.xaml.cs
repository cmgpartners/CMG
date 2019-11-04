using CMG.DataAccess.Interface;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.IO;
using System.Windows;
using CMG.DataAccess.Domain;
using Microsoft.EntityFrameworkCore;
using CMG.DataAccess;
using AutoMapper;
using CMG.Application.Mapper;
using System.Diagnostics;
using System.Linq;

namespace CMG.UI
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : System.Windows.Application
    {
        public IServiceProvider ServiceProvider { get; private set; }

        protected void OnStartUp(object sernder, StartupEventArgs e)
        {            
            //Process proc = Process.GetCurrentProcess();
            //int count = Process.GetProcesses().Where(p=> 
            //    p.ProcessName == proc.ProcessName).Count();

            //if (count <= 1)
            //{
                var configurationBuilder = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json");

                IConfiguration configuration = configurationBuilder.Build();
                ServiceCollection serviceCollection = new ServiceCollection();

                ConfigureServices(serviceCollection, configuration);
                ServiceProvider = serviceCollection.BuildServiceProvider();

                var mainWindow = ServiceProvider.GetRequiredService<MainWindow>();
                mainWindow.Show();
          //  }
        }

        private void ConfigureServices(IServiceCollection services, IConfiguration configuration)
        {
            services.AddDbContext<pb2Context>(connection => connection.UseSqlServer(configuration.GetConnectionString("Default")));
            services.AddScoped<IUnitOfWork, UnitOfWork>();
            services.AddTransient(typeof(MainWindow));

            var mappingConfig = new MapperConfiguration(mc =>
            {
                mc.AddProfile(new CommissionMapperProfile());
                mc.AddProfile(new AgentMapperProfile());
                mc.AddProfile(new PolicyMapperProfile());
                mc.AddProfile(new WithdrawalMapperProfile());
            });
            IMapper mapper = mappingConfig.CreateMapper();
            services.AddSingleton(mapper);
        }
    }
}
