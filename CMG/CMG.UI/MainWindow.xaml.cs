//using CMG.Application.Command;
using System.Windows;
using System.Windows.Controls;
using CMG.DataAccess.Interface;
using CMG.Application.ViewModel;
using AutoMapper;
using System.Windows.Navigation;
using System.Diagnostics;
using static CMG.Common.Enums;

namespace CMG.UI
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public readonly IMapper _mapper;
        public readonly IUnitOfWork _unitOfWork;
        public string _navigateURL = "https://cmgpartners.my.salesforce.com/";
        private MainViewModel _mainViewModel;

        public int[] years { get; set; }
        public MainWindow(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            InitializeComponent();
            _mainViewModel = new MainViewModel(_unitOfWork, _mapper);
            lstNavItems.SelectedItem = lstNavItems.Items[0];
        }

        private void LstNavItems_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListView lstNavigation = (ListView)sender;
            if (lstNavigation.SelectedIndex == 0)
            {
                _mainViewModel.SelectedIndexLeftNavigation = (int)LeftNavigation.Renewals;
                RenewalsViewModel renewalsViewModel = new RenewalsViewModel(_unitOfWork, _mapper);
                _mainViewModel.SelectedViewModel = renewalsViewModel;
                DataContext = _mainViewModel;
            }
            else if (lstNavigation.SelectedIndex == 1)
            {
                if (!(_mainViewModel.SelectedViewModel is FYCViewModel))
                {
                    _mainViewModel.SelectedIndexLeftNavigation = (int)LeftNavigation.FirstYearCommission;
                    FYCViewModel fycViewModel = new FYCViewModel(_unitOfWork, _mapper);
                    _mainViewModel.SelectedViewModel = fycViewModel;
                    DataContext = _mainViewModel;
                }
            }
            else if (lstNavigation.SelectedIndex == 2)
            {
                if (!(_mainViewModel.SelectedViewModel is FinanceSummaryViewModel))
                {
                    _mainViewModel.SelectedIndexLeftNavigation = (int)LeftNavigation.FirstYearCommission;
                    FinanceSummaryViewModel financeSummaryViewModel = new FinanceSummaryViewModel(_unitOfWork, _mapper);
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
                    SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper);
                    _mainViewModel.SelectedViewModel = searchViewModel;
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
    }
}
