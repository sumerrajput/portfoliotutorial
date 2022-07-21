select * from
portfolio_tutorial.dbo.Nashvillehousing

--date format

select SaleDateconvert, convert(Date, SaleDate)
from portfolio_tutorial.dbo.Nashvillehousing


update Nashvillehousing
set SaleDate = CONVERT(Date,SaleDate)

Alter table NashvilleHousing
add SaleDateconvert Date;

Update Nashvillehousing
set SaleDateconvert = convert(Date,SaleDate)

-- property address

select * from
portfolio_tutorial.dbo.Nashvillehousing
--where PropertyAddress is null
order by ParcelID


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
from portfolio_tutorial.dbo.Nashvillehousing a
join portfolio_tutorial.dbo.Nashvillehousing b
    on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


update a
set PropertyAddress= ISNULL(a.PropertyAddress,b.PropertyAddress)
from portfolio_tutorial.dbo.Nashvillehousing a
join portfolio_tutorial.dbo.Nashvillehousing b
    on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


--breakdown  address data

select PropertyAddress
from portfolio_tutorial.dbo.Nashvillehousing
--where PropertyAddress is null
--order by ParcelID

select 
SUBSTRING(PropertyAddress,1,charindex(',',PropertyAddress) -1) as address
,SUBSTRING(PropertyAddress,charindex(',',PropertyAddress) +1,len(PropertyAddress)) as address
from portfolio_tutorial.dbo.Nashvillehousing


Alter table NashvilleHousing
add PropertysplitAddress Nvarchar(255);

Update Nashvillehousing
set PropertysplitAddress = SUBSTRING(PropertyAddress,1,charindex(',',PropertyAddress) -1)


Alter table NashvilleHousing
add Propertysplitcity Nvarchar(255);

Update Nashvillehousing
set Propertysplitcity = SUBSTRING(PropertyAddress,charindex(',',PropertyAddress) +1,len(PropertyAddress))

select *
from portfolio_tutorial.dbo.Nashvillehousing


--breakingdown owner data

select OwnerAddress
from portfolio_tutorial.dbo.Nashvillehousing

select 
PARSENAME(replace(OwnerAddress,',' , '.'),3)
,PARSENAME(replace(OwnerAddress,',' , '.'),2)
,PARSENAME(replace(OwnerAddress,',' , '.'),1)
from portfolio_tutorial.dbo.Nashvillehousing


Alter table NashvilleHousing
add OwnersplitAddress Nvarchar(255);

Update Nashvillehousing
set OwnersplitAddress = PARSENAME(replace(OwnerAddress,',' , '.'),3)

Alter table NashvilleHousing
add Ownersplitcity Nvarchar(255);

Update Nashvillehousing
set Ownersplitcity = PARSENAME(replace(OwnerAddress,',' , '.'),2)

Alter table NashvilleHousing
add Ownersplitstate Nvarchar(255);

Update Nashvillehousing
set Ownersplitstate = PARSENAME(replace(OwnerAddress,',' , '.'),1)


select*
from portfolio_tutorial.dbo.Nashvillehousing



--change y and n to yes, no in vacient place

select Distinct(SoldAsVacant),count(SoldAsVacant)
from portfolio_tutorial.dbo.Nashvillehousing
Group by SoldAsVacant
order by 2


select SoldAsVacant
,case when SoldAsVacant= 'Y' Then 'Yes'
      when SoldAsVacant= 'N' Then 'No'
	  Else SoldAsVacant
	  End
from portfolio_tutorial.dbo.Nashvillehousing


update Nashvillehousing
SET SoldAsVacant= case when SoldAsVacant= 'Y' Then 'Yes'
          when SoldAsVacant= 'N' Then 'No'
		  Else SoldAsVacant
	      End



		  --remove duplicate




		  --delete columns

select * 
from portfolio_tutorial.dbo.Nashvillehousing


alter table portfolio_tutorial.dbo.Nashvillehousing
drop column OwnerAddress, TaxDistrict,PropertyAddress
