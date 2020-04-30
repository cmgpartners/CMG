using System.Windows;
using System.Windows.Controls;
using CMG.DataAccess.Interface;
using CMG.Application.ViewModel;
using AutoMapper;
using System.Windows.Navigation;
using System.Diagnostics;
using static CMG.Common.Enums;
using ToastNotifications;
using ToastNotifications.Position;
using ToastNotifications.Lifetime;
using System;
using CMG.Service.Interface;
using System.Windows.Threading;
using System.Windows.Media;
using Microsoft.Extensions.Caching.Memory;

namespace CMG.UI
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public readonly IMapper _mapper;
        public readonly IUnitOfWork _unitOfWork;
        public readonly IMemoryCache _memoryCache;
        public readonly IDialogService _dialogService;
        public readonly IReportService _reportService;
        public string _navigateURL = "https://cmgpartners.my.salesforce.com/";
        private MainViewModel _mainViewModel;
        private Notifier _notifier;
        private Window window;

        public int[] years { get; set; }
        public MainWindow(IUnitOfWork unitOfWork, IMapper mapper, IMemoryCache memoryCache = null, IDialogService dialogService = null, IReportService reportService = null)
        {
            InitializeComponent();
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _memoryCache = memoryCache;
            _dialogService = dialogService;
            _reportService = reportService;
            _notifier = InitializeNotifier();
            _mainViewModel = new MainViewModel(_unitOfWork, _mapper, _memoryCache, _notifier);
            if (_mainViewModel.HasCommissionAccess)
                lstNavItems.SelectedItem = lstNavItems.Items[0];
            else
            {
                PeopleMenu_Click(new object(), new RoutedEventArgs());
                CommissionHeaderRow.Height = new GridLength(0);
                CollapsibleRow.Height = new GridLength(0);
            }
        }
        private void LstNavItems_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListView lstNavigation = (ListView)sender;
            GetSelectedClient();
            if (lstNavigation.SelectedIndex == 0)
            {
                _mainViewModel.SelectedIndexLeftNavigation = (int)LeftNavigation.Renewals;
                RenewalsViewModel renewalsViewModel = new RenewalsViewModel(_unitOfWork, _mapper,_dialogService, _notifier, _reportService);
                _mainViewModel.SelectedViewModel = renewalsViewModel;
                DataContext = _mainViewModel;
                if(_mainViewModel.CopiedCommission != null)
                {
                    renewalsViewModel.CopiedCommission = _mainViewModel.CopiedCommission;
                }
            }
            else if (lstNavigation.SelectedIndex == 1)
            {
                if (!(_mainViewModel.SelectedViewModel is FYCViewModel))
                {
                    _mainViewModel.SelectedIndexLeftNavigation = (int)LeftNavigation.FirstYearCommission;
                    FYCViewModel fycViewModel = new FYCViewModel(_unitOfWork, _mapper, _notifier);
                    _mainViewModel.SelectedViewModel = fycViewModel;
                    DataContext = _mainViewModel;
                }
            }
            else if (lstNavigation.SelectedIndex == 2)
            {
                if (!(_mainViewModel.SelectedViewModel is FinanceSummaryViewModel))
                {
                    _mainViewModel.SelectedIndexLeftNavigation = (int)LeftNavigation.FirstYearCommission;
                    FinanceSummaryViewModel financeSummaryViewModel = new FinanceSummaryViewModel(_unitOfWork, _mapper, _dialogService, _notifier);
                    _mainViewModel.SelectedViewModel = financeSummaryViewModel;
                    DataContext = _mainViewModel;
                    lstNavItems.SelectedItem = lstNavItems.Items[2];
                }
            }
            else if (lstNavigation.SelectedIndex == 3)
            {
                if (!(_mainViewModel.SelectedViewModel is SearchViewModel))
                {
                    _mainViewModel.SelectedIndexLeftNavigation = (int)LeftNavigation.Search;
                    SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper, _notifier);
                    _mainViewModel.SelectedViewModel = searchViewModel;
                    DataContext = _mainViewModel;
                }
            }
            if(lstNavigation.SelectedIndex >= 0)
            {
                ResetMenuSelection(true);
            }           
        }
        private void PolicyMenu_Click(object sender, RoutedEventArgs e)
        {
            GetSelectedClient();
            ResetMenuSelection(false);
            PolicyMenu.Background = (SolidColorBrush)(new BrushConverter().ConvertFrom("#00A3FF"));
            PolicyViewModel policyViewModel;
            if (_mainViewModel.MainSelectedClient != null)
            {
                policyViewModel = new PolicyViewModel(_unitOfWork, _mapper,  _memoryCache, _dialogService, _notifier, _mainViewModel.MainSelectedClient);
            }
            else
            {
                policyViewModel = new PolicyViewModel(_unitOfWork, _mapper, _memoryCache, _dialogService, _notifier);
            }
            policyViewModel.ClientCollection = _mainViewModel.ClientCollection;
            _mainViewModel.SelectedViewModel = policyViewModel;
            policyViewModel.PolicyNumber = _mainViewModel.PolicyNumber;
            DataContext = _mainViewModel;
        }
        private void FileManagerMenu_Click(object sender, RoutedEventArgs e)
        {
            GetSelectedClient();
            ResetMenuSelection(false);
            FileManagerMenu.Background = (SolidColorBrush)new BrushConverter().ConvertFrom("#00A3FF");
            FileManagerViewModel fileManagerViewModel;
            if (_mainViewModel.MainSelectedClient != null)
            {
                fileManagerViewModel = new FileManagerViewModel(_unitOfWork, _mapper, _memoryCache, _dialogService, _notifier, _mainViewModel.MainSelectedClient);
            }
            else
            {
                fileManagerViewModel = new FileManagerViewModel(_unitOfWork, _mapper, _memoryCache, _dialogService, _notifier);
            }
            fileManagerViewModel.ClientCollection = _mainViewModel.ClientCollection;
            _mainViewModel.SelectedViewModel = fileManagerViewModel;
            fileManagerViewModel.PolicyNumber = _mainViewModel.PolicyNumber;
            DataContext = _mainViewModel;
        }
        private void ConfigurationMenu_Click(object sender, RoutedEventArgs e)
        {
            GetSelectedClient();
            ResetMenuSelection(false);
            ConfigurationMenu.Background = (SolidColorBrush)new BrushConverter().ConvertFrom("#00A3FF");
            ConfigurationViewModel configurationViewModel = new ConfigurationViewModel(_unitOfWork, _mapper, _dialogService, _notifier);
            _mainViewModel.SelectedViewModel = configurationViewModel;
            DataContext = _mainViewModel;            
        }
        private void PeopleMenu_Click(object sender, RoutedEventArgs e)
        {
            GetSelectedClient();
            ResetMenuSelection(false);
            PeopleMenu.Background = (SolidColorBrush)(new BrushConverter().ConvertFrom("#00A3FF"));
            PeopleViewModel peopleViewModel;
            if (_mainViewModel.MainSelectedClient != null)
            {
                peopleViewModel = new PeopleViewModel(_unitOfWork, _mapper, _memoryCache, _dialogService, _notifier, _mainViewModel.MainSelectedClient);
            }
            else
            {
                peopleViewModel = new PeopleViewModel(_unitOfWork, _mapper, _memoryCache, _dialogService, _notifier);
            }
            peopleViewModel.ClientCollection = _mainViewModel.ClientCollection;
            _mainViewModel.SelectedViewModel = peopleViewModel;
            peopleViewModel.PolicyNumber = _mainViewModel.PolicyNumber;
            DataContext = _mainViewModel;
        }
        private void SalesforceMenu_Click(object sender, RoutedEventArgs e)
        {
            NavigateToSalesforce();
        }
        protected override void OnClosed(EventArgs e)
        {
            base.OnClosed(e);
            App.Current.Shutdown();
        }
        private void ButtonMenuOpen_Click(object sender, RoutedEventArgs e)
        {
            ButtonMenuOpen.Visibility = Visibility.Collapsed;
            ButtonMenuClose.Visibility = Visibility.Visible;
            CollapsibleRow.Height = new GridLength(245);
            FileManagerMenu.Background = null;
            lstNavItems.SelectedIndex = -1;
        }
        private void ButtonMenuClose_Click(object sender, RoutedEventArgs e)
        {
            CloseCommissionMenu();
        }

        #region Helper Methods
        private Notifier InitializeNotifier()
        {
            if (System.Windows.Application.Current.Windows.Count > 1
                && System.Windows.Application.Current.Windows[1].Name == "CmgApp")
            {
                window = System.Windows.Application.Current.Windows[1];
            }
            return new Notifier(cfg =>
            {
                cfg.PositionProvider = new WindowPositionProvider(
                    parentWindow: window,
                    corner: Corner.TopRight,
                    offsetX: 10,
                    offsetY: 10);

                cfg.LifetimeSupervisor = new TimeAndCountBasedLifetimeSupervisor(
                    notificationLifetime: TimeSpan.FromSeconds(3),
                    maximumNotificationCount: MaximumNotificationCount.FromCount(5));

                cfg.Dispatcher = System.Windows.Application.Current.Dispatcher;
            });
        }
        private void NavigateToSalesforce()
        {
            string salesForceId = string.Empty;
            if (_mainViewModel.SelectedViewModel is PeopleViewModel
                && ((PeopleViewModel)_mainViewModel.SelectedViewModel).SelectedClient != null)
            {
                salesForceId = ((PeopleViewModel)_mainViewModel.SelectedViewModel).SelectedClient.SalesforceId;
            }
            if (_mainViewModel.SelectedViewModel is PolicyViewModel
                && ((PolicyViewModel)_mainViewModel.SelectedViewModel).SelectedClient != null)
            {
                salesForceId = ((PolicyViewModel)_mainViewModel.SelectedViewModel).SelectedClient.SalesforceId;
            }
            if (_mainViewModel.SelectedViewModel is FileManagerViewModel
                && ((FileManagerViewModel)_mainViewModel.SelectedViewModel).SelectedClient != null)
            {
                salesForceId = ((FileManagerViewModel)_mainViewModel.SelectedViewModel).SelectedClient.SalesforceId;
            }
            ProcessStartInfo psi = new ProcessStartInfo
            {
                FileName = _navigateURL + salesForceId,
                UseShellExecute = true
            };
            Process.Start(psi);
        }
        private void CloseCommissionMenu()
        {
            ButtonMenuOpen.Visibility = Visibility.Visible;
            ButtonMenuClose.Visibility = Visibility.Collapsed;
            var timer = new DispatcherTimer { Interval = TimeSpan.FromMilliseconds(450) };
            timer.Start();
            timer.Tick += (sender, args) =>
            {
                timer.Stop();
                if(_mainViewModel.HasCommissionAccess)
                    CollapsibleRow.Height = new GridLength(45);
            };
        }
        private void ResetMenuSelection(bool isCommissionMenuSelected)
        {
            PolicyMenu.Background = null;
            FileManagerMenu.Background = null;
            ConfigurationMenu.Background = null;
            PeopleMenu.Background = null;
            if (!isCommissionMenuSelected)
            {
                CloseCommissionMenu();
            }
        }
        private void GetSelectedClient()
        {
            if (_mainViewModel.SelectedViewModel != null
                && _mainViewModel.SelectedViewModel is PolicyViewModel)
            {
                _mainViewModel.ClientCollection = ((PolicyViewModel)_mainViewModel.SelectedViewModel).ClientCollection;
                _mainViewModel.MainSelectedClient = ((PolicyViewModel)_mainViewModel.SelectedViewModel).SelectedClient;
            }
            else if (_mainViewModel.SelectedViewModel != null
                && _mainViewModel.SelectedViewModel is FileManagerViewModel)
            {
                _mainViewModel.ClientCollection = ((FileManagerViewModel)_mainViewModel.SelectedViewModel).ClientCollection;
                _mainViewModel.MainSelectedClient = ((FileManagerViewModel)_mainViewModel.SelectedViewModel).SelectedClient;
            }
            else if (_mainViewModel.SelectedViewModel != null
                && _mainViewModel.SelectedViewModel is PeopleViewModel)
            {
                _mainViewModel.ClientCollection = ((PeopleViewModel)_mainViewModel.SelectedViewModel).ClientCollection;
                _mainViewModel.MainSelectedClient = ((PeopleViewModel)_mainViewModel.SelectedViewModel).SelectedClient;
            }
        }
        #endregion     
    }
}
