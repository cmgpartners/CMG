//using CMG.Application.Command;
using System.Windows;
using System.Windows.Controls;
using CMG.DataAccess.Interface;
using CMG.Application.ViewModel;
using AutoMapper;
using System.Windows.Navigation;
using System.Diagnostics;

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

        public int[] years { get; set; }
        public MainWindow(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            InitializeComponent();
            lstNavItems.SelectedItem = lstNavItems.Items[0];
        }

        private void LstNavItems_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListView lstNavigation = (ListView)sender;
            if (lstNavigation.SelectedIndex == 0)
            {
                DataContext = new RenewalsViewModel(_unitOfWork, _mapper);
            }
            else if (lstNavigation.SelectedIndex == 3)
            {
                DataContext = new SearchViewModel(_unitOfWork, _mapper);
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

        private void Button_SettingsClick(object sender, RoutedEventArgs e)
        {
            DataContext = new AgentViewModel(_unitOfWork, _mapper);
        }
    }
}
