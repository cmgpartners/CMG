//using CMG.Application.Command;
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

namespace CMG.UI
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public readonly IMapper _mapper;
        public readonly IUnitOfWork _unitOfWork;
        public readonly IDialogService _dialogService;
        public string _navigateURL = "https://cmgpartners.my.salesforce.com/";
        private MainViewModel _mainViewModel;
        private Notifier _notifier;

        public int[] years { get; set; }
        public MainWindow(IUnitOfWork unitOfWork, IMapper mapper, IDialogService dialogService = null)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _dialogService = dialogService;
            _notifier = InitializeNotifier();
            InitializeComponent();
            _mainViewModel = new MainViewModel(_unitOfWork, _mapper, _notifier);
            lstNavItems.SelectedItem = lstNavItems.Items[0];
        }
        private void LstNavItems_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListView lstNavigation = (ListView)sender;
            if (lstNavigation.SelectedIndex == 0)
            {
                _mainViewModel.SelectedIndexLeftNavigation = (int)LeftNavigation.Renewals;
                RenewalsViewModel renewalsViewModel = new RenewalsViewModel(_unitOfWork, _mapper,_dialogService, _notifier);
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
            else if (lstNavigation.SelectedIndex == 5)
            {
                if (!(_mainViewModel.SelectedViewModel is PolicyViewModel))
                {
                    _mainViewModel.SelectedIndexLeftNavigation = (int)LeftNavigation.Search;
                    PolicyViewModel policyViewModel = new PolicyViewModel(_unitOfWork, _mapper, _dialogService, _notifier);
                    _mainViewModel.SelectedViewModel = policyViewModel;
                    DataContext = _mainViewModel;
                }
            }
        }
        private void Hyperlink_RequestNavigate(object sender, RequestNavigateEventArgs e)
        {
            NavigateToSalesforce();
        }
        private void Button_NavigationClick(object sender, RoutedEventArgs e)
        {
            NavigateToSalesforce();
        }
        private void NavigateToSalesforce()
        {
            ProcessStartInfo psi = new ProcessStartInfo
            {
                FileName = _navigateURL,
                UseShellExecute = true
            };
            Process.Start(psi);
        }
        private Notifier InitializeNotifier()
        {
            return new Notifier(cfg =>
            {
                cfg.PositionProvider = new WindowPositionProvider(
                    parentWindow: System.Windows.Application.Current.MainWindow,
                    corner: Corner.TopRight,
                    offsetX: 10,
                    offsetY: 10);

                cfg.LifetimeSupervisor = new TimeAndCountBasedLifetimeSupervisor(
                    notificationLifetime: TimeSpan.FromSeconds(3),
                    maximumNotificationCount: MaximumNotificationCount.FromCount(5));

                cfg.Dispatcher = System.Windows.Application.Current.Dispatcher;
            });
        }

        private void ButtonMenuOpen_Click(object sender, RoutedEventArgs e)
        {
            ButtonMenuOpen.Visibility = Visibility.Collapsed;
            ButtonMenuClose.Visibility = Visibility.Visible;
            PolicyMenu.Background = null;
            CollapsibleRow.Height = new GridLength(230);
        }

        private void ButtonMenuClose_Click(object sender, RoutedEventArgs e)
        {
            CloseCommissionMenu();
        }

        private void PolicyMenu_Click(object sender, RoutedEventArgs e)
        {
            PolicyMenu.Background = (SolidColorBrush)(new BrushConverter().ConvertFrom("#00A3FF"));
            CloseCommissionMenu();
            PolicyViewModel policyViewModel = new PolicyViewModel(_unitOfWork, _mapper, _dialogService, _notifier);
            _mainViewModel.SelectedViewModel = policyViewModel;
            DataContext = _mainViewModel;
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
                CollapsibleRow.Height = new GridLength(40);
            };
        }
    }
}
