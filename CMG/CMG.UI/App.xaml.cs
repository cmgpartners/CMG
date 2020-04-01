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
using CMG.Service.Interface;
using CMG.Service;
using System.Threading;
using System.DirectoryServices.AccountManagement;
using System.Windows.Input;

namespace CMG.UI
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : System.Windows.Application
    {
        public IServiceProvider ServiceProvider { get; private set; }
        public object mainWindow;

        protected void OnStartUp(object sernder, StartupEventArgs e)
        {
            Mutex myMutex;
            bool isNewInstance;
            myMutex = new Mutex(false, "CMG.UI", out isNewInstance);
            if (!isNewInstance)
            {
                App.Current.Shutdown();
            }
            try
            {
                using (var ctx = new PrincipalContext(ContextType.Domain))
                {
                    using (var user = UserPrincipal.FindByIdentity(ctx, Environment.UserName))
                    {
                        if (user == null)
                        {
                            MessageBox.Show("Sorry, you do not have access to the application", "Access Denied");
                            App.Current.Shutdown();
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
                App.Current.Shutdown();
                Environment.Exit(0);
            }

            try
            {
                var configurationBuilder = new ConfigurationBuilder()
                        .SetBasePath(Directory.GetCurrentDirectory())
                        .AddJsonFile("appsettings.json");
                var progressbarWindow = new ProgressbarWindow();
                progressbarWindow.Show();
                IConfiguration configuration = configurationBuilder.Build();
                ServiceCollection serviceCollection = new ServiceCollection();

                ConfigureServices(serviceCollection, configuration);
                ServiceProvider = serviceCollection.BuildServiceProvider();

                mainWindow = ServiceProvider.GetRequiredService<MainWindow>();                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                App.Current.Shutdown();
                Environment.Exit(0);
            }
        }

        private void ConfigureServices(IServiceCollection services, IConfiguration configuration)
        {
            services.AddDbContext<pb2Context>(connection => connection.UseSqlServer(configuration.GetConnectionString("Default")));
            services.AddScoped<IUnitOfWork, UnitOfWork>();
            services.AddScoped<IDialogService, DialogService>();
            services.AddScoped<IReportService, ReportService>();
            services.AddMemoryCache();
            services.AddTransient(typeof(MainWindow));

            var mappingConfig = new MapperConfiguration(mc =>
            {
                mc.AddProfile(new CommissionMapperProfile());
                mc.AddProfile(new AgentMapperProfile());
                mc.AddProfile(new PolicyMapperProfile());
                mc.AddProfile(new WithdrawalMapperProfile());
                mc.AddProfile(new ComboMapperProfile());
                mc.AddProfile(new CaseMapperProfile());
                mc.AddProfile(new ClientSearchProfiler());
                mc.AddProfile(new PeopleMapperProfile());
                mc.AddProfile(new BusinessRelationMapperProfile());
                mc.AddProfile(new PolicyIllustrationMapperProfile());
            });
            IMapper mapper = mappingConfig.CreateMapper();
            services.AddSingleton(mapper);
        }
    }
}
