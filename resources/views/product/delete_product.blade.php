@extends('/layouts.main')
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

@push('css-dependencies')
<link rel="stylesheet" type="text/css" href="/css/product.css" />
@endpush

@push('scripts-dependencies')
<script src="/js/product.js" type="module"></script>
@endpush

@section('content')
<div class="container-fluid p-4" style="background: #eee;">

  @include('partials/breadcumb')

  <div class="row flex-lg-nowrap">

    <div class="col">
      <div class="row">
        <div class="col mb-3">
          <div class="card">
            <div class="card-body">
              <div class="e-profile">
                <ul class="nav nav-tabs">
                  <li class="nav-item"><a href="#" class="active nav-link">Delete Confirmation</a></li>
                </ul>
                <div class="tab-content pt-3">
                  <div class="tab-pane active">
                    <div class="row">
                      <div class="col">
                        <p>Are you sure you want to delete the product <strong>{{ $product->product_name }}</strong>?</p>
                        <form action="/product/{{ $product->id }}/delete_product" method="post">
                          @csrf
                          @method('DELETE')
                          <div class="row">
                            <div class="col d-flex justify-content-end">
                              <a class="btn btn-secondary mx-3" href="/product">Cancel</a>
                              <button class="btn btn-danger" type="submit">Delete Product</button>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
@endsection
