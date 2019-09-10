using CMG.DataAccess.Interface;
using CMG.DataAccess.Respository;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
//using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using CMG.DataAccess.Domain;
using Microsoft.EntityFrameworkCore;
using CMG.DataAccess;
using AutoMapper;
using CMG.Application.Mapper;

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
            var configurationBuilder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json");

            IConfiguration configuration = configurationBuilder.Build();
            ServiceCollection serviceCollection = new ServiceCollection();

            ConfigureServices(serviceCollection, configuration);
            ServiceProvider = serviceCollection.BuildServiceProvider();

            var mainWindow = ServiceProvider.GetRequiredService<MainWindow>();
            mainWindow.Show();
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
            });
            IMapper mapper = mappingConfig.CreateMapper();
            services.AddSingleton(mapper);
        }
    }
}
