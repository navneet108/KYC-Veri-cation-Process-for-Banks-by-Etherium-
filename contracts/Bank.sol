pragma solidity ^ 0.5 .9;

//Contract KYC

contract Bank {

    bool public isallowed;
    address owner;
    int256 totalbank = 0;


    // Structure of customer

    struct customer {
        string custname; //Unique
        string custdata;
        bool status;
        uint256 downvote;
        uint256 upvote;
        address custbank;
    }

    //Mapping of customer struct to string(username)

    mapping(string => customer) public customers;



    // Structure of bank

    struct bank {
        string bankname;
        address ethaddress;
        uint256 report;
        uint256 count;
        bool kycpermission;
        string regnumber;
    }

    //Mapping of customer struct to address

    mapping(address => bank) public banks;
    mapping(address => bool) isbank;



    // Structure of kycrequest

    struct kycreq {
        string custname; //Unique
        address bankadd;
        string kycdata;
    }

    //Mapping of customer struct to Kycrequest(username)

    mapping(string => kycreq) public kycreqs;



    // Main constructor of the contract

  //  constructor() public {
    //    owner = msg.sender;
    //}



    //Add Request function

    function addreq(address ethaddress, string memory custname, string memory kycdata) public returns(bool) {

        //    if(banks[ethaddress].kycpermission==false)
        require(banks[ethaddress].kycpermission == false); {
            kycreqs[custname].custname = custname;
            kycreqs[custname].kycdata = kycdata;
            return true;
        }
    }



    //Add Customer function

    function addcust(string memory custname, string memory custdata) public {

        require(customers[custname].custbank != address(0)); {
            customers[custname].custname = custname;
            customers[custname].custdata = custdata;
        }

    }



    //Remove Request function

    function remreq(string memory kycname) public returns(bool) {

        delete kycreqs[kycname];
        return true;

    }



    //Remove Customer function

    function remcust(string memory custname) public returns(bool) {
        require(customers[custname].custbank != address(0)); {
            delete customers[custname];
            delete kycreqs[custname];
            return true;
        }
    }



    //View Customer function

    function viewcust(string calldata custname) external view returns(string memory, string memory) {

        require(customers[custname].custbank != address(0)); {
            return (customers[custname].custname, customers[custname].custdata);
        }

    }



    //Upvote function

    function uvote(string memory custname) public returns(bool) {
        customers[custname].upvote++;
        return true;
    }




    //Downvote function

    function dvote(string memory custname) public returns(bool) {
        customers[custname].downvote--;
        return true;
    }




    //Modify Customer function

    function modcust(string memory custname) public returns(bool) {
        delete kycreqs[custname];
        customers[custname].upvote = 0;
        customers[custname].downvote = 0;
        return true;
    }



    //Add Bank Reports function

    function addbankreport(address ethaddress) public {
        banks[ethaddress].report += 1;
    }



    //Get Bank Reports function

    function seebankreport(address ethaddress) public view returns(uint256) {
        return (banks[ethaddress].report);
    }



    //Get Customer Status function

    function custstatus(string memory custname) public view returns(bool) {

        if (customers[custname].status == true) {
            return true;
        } else {
            return false;
        }
    }



    //View Bank Details function

    function bankdetail(address _address) public view returns(string memory, address, uint256, uint256, string memory) {
        return (banks[_address].bankname, banks[_address].ethaddress, banks[_address].report, banks[_address].count, banks[_address].regnumber);
    }



    //Add Bank function

    function addbank(string memory bankname, address _address, string memory regnumber) public {
        require(msg.sender == owner); {
            banks[_address].bankname = bankname;
            banks[_address].regnumber = regnumber;
            banks[_address].count = 0;
            banks[_address].report = 0;
            banks[_address].kycpermission = false;
        }
        totalbank++;
    }



    //Modify bank kycPermission function

    function modifybank(address _address) public {
        require(msg.sender == owner); {
            banks[_address].kycpermission = true;
        }
    }



    //Remove Bank  function

    function rembank(address _address) public {
        require(msg.sender == owner); {
            delete banks[_address];
        }
    }


}
