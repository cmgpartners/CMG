//using CMG.Application.Command;
using System.Windows;
using System.Windows.Controls;
using CMG.DataAccess.Interface;
using CMG.Application.ViewModel;
using AutoMapper;

namespace CMG.UI
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public readonly IMapper _mapper;
        public readonly IUnitOfWork _unitOfWork;

        public int[] years { get; set; }
        public MainWindow(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;

            InitializeComponent();
            lstNavItems.SelectedItem = lstNavItems.Items[0];

            //SearchViewModel searchViewModel = new SearchViewModel(unitOfWork, mapper);
            //searchViewModel.PolicyNumber = "CP0126832";
            //searchViewModel.Search();
        }

        private void btnShutDown_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.Application.Current.Shutdown(99);
        }

        private void LstNavItems_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListView lstNavigation = (ListView)sender;
            if (lstNavigation.SelectedIndex == 0)
            {
                DataContext = new CommissionViewModel(_unitOfWork, _mapper);
            }
            else if (lstNavigation.SelectedIndex == 3)
            {
                DataContext = new SearchViewModel(_unitOfWork, _mapper);
            }
        }
    }
}
